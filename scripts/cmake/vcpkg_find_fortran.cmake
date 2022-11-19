#[===[.md:
# vcpkg_find_fortran

Checks if a Fortran compiler can be found.
Windows(x86/x64) Only: If not it will switch/enable MinGW gfortran 
                       and return required cmake args for building. 

## Usage
```cmake
vcpkg_find_fortran(<additional_cmake_args_out>)
```
#]===]

function(vcpkg_find_fortran additional_cmake_args_out)
    set(ARGS_OUT)
    set(CMAKE_BINARY_DIR "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}")
    set(CMAKE_CURRENT_BINARY_DIR "${CMAKE_BINARY_DIR}")
    set(CMAKE_PLATFORM_INFO_DIR "${CMAKE_BINARY_DIR}/Platform")
    include(CMakeDetermineFortranCompiler)
    if(NOT CMAKE_Fortran_COMPILER AND NOT VCPKG_CHAINLOAD_TOOLCHAIN_FILE)
    # This intentionally breaks users with a custom toolchain which do not have a Fortran compiler setup
    # because they either need to use a port-overlay (for e.g. lapack), remove the toolchain for the port using fortran
    # or setup fortran in their VCPKG_CHAINLOAD_TOOLCHAIN_FILE themselfs!
        if(WIN32)
            message(STATUS "No Fortran compiler found on the PATH. Using MinGW gfortran!")
            # If no Fortran compiler is on the path we switch to use gfortan from MinGW within vcpkg
            if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
                set(MINGW_PATH mingw32)
                set(MACHINE_FLAG -m32)
                vcpkg_acquire_msys(MSYS_ROOT
                    DIRECT_PACKAGES
                        "https://repo.msys2.org/mingw/i686/mingw-w64-i686-gcc-fortran-10.2.0-1-any.pkg.tar.zst"
                        ddbdaf9ea865181e16a0931b2ec88c2dcef8add34628e479c7b9de4fa2ccb22e09c7239442e58702e0acd3adabc920565e976984f2bcd90a3668bf7f48a245f1
                        "https://repo.msys2.org/mingw/i686/mingw-w64-i686-gcc-libgfortran-10.2.0-1-any.pkg.tar.zst"
                        150f355085fcf4c54e8bce8f7f08b90fea9ca7e1f32cff0a2e495faa63cf7723f4bf935f0f4ec77c8dd2ba710ceaed88694cb3da71def5e2088dd65e13c9b002
                        "https://repo.msys2.org/mingw/i686/mingw-w64-i686-gcc-libs-10.2.0-1-any.pkg.tar.zst"
                        113d8b3b155ea537be8b99688d454f781d70c67c810c2643bc02b83b332d99bfbf3a7fcada6b927fda67ef02cf968d4fdf930466c5909c4338bda64f1f3f483e
                        "https://repo.msys2.org/mingw/i686/mingw-w64-i686-gmp-6.2.0-1-any.pkg.tar.xz"
                        37747f3f373ebff1a493f5dec099f8cd6d5abdc2254d9cd68a103ad7ba44a81a9a97ccaba76eaee427b4d67b2becb655ee2c379c2e563c8051b6708431e3c588
                        "https://repo.msys2.org/mingw/i686/mingw-w64-i686-libwinpthread-git-8.0.0.5906.c9a21571-1-any.pkg.tar.zst"
                        2c3d9e6b2eee6a4c16fd69ddfadb6e2dc7f31156627d85845c523ac85e5c585d4cfa978659b1fe2ec823d44ef57bc2b92a6127618ff1a8d7505458b794f3f01c
                        "https://repo.msys2.org/mingw/i686/mingw-w64-i686-winpthreads-git-8.0.0.5906.c9a21571-1-any.pkg.tar.zst"
                        e87ad4f4071c6b5bba3b13a85abf6657bb494b73c57ebe65bc5a92e2cef1d9de354e6858d1338ee72809e3dc742ba69ce090aaad4560ae1d3479a61dbebf03c6
                        "https://repo.msys2.org/mingw/i686/mingw-w64-i686-mpc-1.1.0-1-any.pkg.tar.xz"
                        d236b815ec3cf569d24d96a386eca9f69a2b1e8af18e96c3f1e5a4d68a3598d32768c7fb3c92207ecffe531259822c1a421350949f2ffabd8ee813654f1af864
                        "https://repo.msys2.org/mingw/i686/mingw-w64-i686-mpfr-4.1.0-2-any.pkg.tar.zst"
                        caac5cb73395082b479597a73c7398bf83009dbc0051755ef15157dc34996e156d4ed7881ef703f9e92861cfcad000888c4c32e4bf38b2596c415a19aafcf893
                        "https://repo.msys2.org/mingw/i686/mingw-w64-i686-gcc-10.2.0-1-any.pkg.tar.zst"
                        3085e744e716301ba8e4c8a391ab09c2d51e587e0a2df5dab49f83b403a32160f8d713cf1a42c1d962885b4c6ee3b6ed36ef40de15c4be2b69dbc3f12f974c3c
                        "https://repo.msys2.org/mingw/i686/mingw-w64-i686-binutils-2.34-3-any.pkg.tar.zst"
                        ff06b2adebe6e9b278b63ca5638ff704750a346faad1cdc40089431b0a308edb6f2a131815e0577673a19878ec1bd8d5a4fa592aa227de769496c1fd3aedbc85
                        "https://repo.msys2.org/mingw/i686/mingw-w64-i686-crt-git-8.0.0.5966.f5da805f-1-any.pkg.tar.zst"
                        120c943ce173719e48400fa18299f3458bc9db4cf18bb5a4dda8a91cc3f816510b337a92f7388077c65b50bbbeae9078793891ceaad631d780b10fde19ad3649
                        "https://repo.msys2.org/mingw/i686/mingw-w64-i686-headers-git-8.0.0.5966.f5da805f-1-any.pkg.tar.zst"
                        dbb9f8258da306a3441f9882faa472c3665a67b2ea68657f3e8a1402dcfacf9787a886a3daf0eefe4946f04557bc166eb15b21c1093ad85c909002daadba1923
                        "https://repo.msys2.org/mingw/i686/mingw-w64-i686-libiconv-1.16-1-any.pkg.tar.xz"
                        ba236e1efc990cb91d459f938be6ca6fc2211be95e888d73f8de301bce55d586f9d2b6be55dacb975ec1afa7952b510906284eff70210238919e341dffbdbeb8
                        "https://repo.msys2.org/mingw/i686/mingw-w64-i686-windows-default-manifest-6.4-3-any.pkg.tar.xz"
                        5b99abc55eaa74cf85ca64a9c91542554cb5c1098bc71effba9bd36242694cfd348503fcd3507fb9ba97486108c092c925e2f38cd744493386b3dc9ab28bc526
                        "https://repo.msys2.org/mingw/i686/mingw-w64-i686-zlib-1.2.11-7-any.pkg.tar.xz"
                        459850a8c42b1d497268736629ef713beee70cd0d3161d02c7a9fad08aca4560f4e17ba02d5cabda8a19d7c614f7e0ef5a6ec13afd91dd3004057139a5469c8f
                        "https://repo.msys2.org/mingw/i686/mingw-w64-i686-zstd-1.4.5-1-any.pkg.tar.zst"
                        68f431073717b59549ab0fd26be8df8afcb43f3dd85be2ffcbc7d1a629999eed924656a7fc3f50937b2e6605a5067542d016181106b7bc3408b89b268ced5d23
                )
            elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
                set(MINGW_PATH mingw64)
                set(MACHINE_FLAG -m64)
                vcpkg_acquire_msys(MSYS_ROOT
                    DIRECT_PACKAGES
                        "https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-gcc-fortran-10.2.0-11-any.pkg.tar.zst"
                        474bdc63d11d33965b655da4cd81e10bddd89c87b1d6ca3fd6fad39f274e572e69b5f901be5a07769d60ac60bc5a5732362a379aa54ec7a61d7a5f6320e9e452
                        "https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-gcc-libgfortran-10.2.0-11-any.pkg.tar.zst"
                        1a3ce322286e0a50b7ccd8f1bb8a23e875d3e21e15a5f37e83027aeb8ee0db6a6e4829dec57e1ac5cbfccd5d887e80dc7fe846a7384fa5c6b9131348fe5ba7fd
                        "https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-gcc-libs-10.2.0-11-any.pkg.tar.zst"
                        b787410d7714f76fe92fc7541e913d24a2e4ef1d816dc71deef022e3f3c9a6e82a2367e05770da4e2e6d3bbc04e41a4d44a4fb6e7875a7a7b6872eba26b4e267
                        "https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-gmp-6.2.1-3-any.pkg.tar.zst"
                        d0d4ed1a046b64f437e72bbcf722b30311dde5f5e768a520141423fc0a3127b116bd62cfd4b5cf5c01a71ee0f9cf6479fcc31277904652d8f6ddbf16e33e0b72
                        "https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-libwinpthread-git-9.0.0.6454.b4445ee52-1-any.pkg.tar.zst"
                        c60f7d16b43da74d3a1aa40574ca77f9593be5ca10da442111fad1429939530bd1627dd36d0fd3b67400adbda0c30925dc4f950afc11428f37f2a3d2c3492e02
                        "https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-winpthreads-git-9.0.0.6454.b4445ee52-1-any.pkg.tar.zst"
                        3e808e2b96ca2939d2ef382f4e152e7c6998bfd47cf2810d741c734eeff2262a7dad9ea04230a2fe94dae914805c9846b6e0fd03d94e0eca5fe388678bc2721e
                        "https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-mpc-1.2.1-1-any.pkg.tar.zst"
                        f2c137dbb0b6feea68dde9739c38b44dcb570324e3947adf991028e8f63c9ff50a11f47be15b90279ff40bcac7f320d952cfc14e69ba8d02cf8190c848d976a1
                        "https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-mpfr-4.1.0-3-any.pkg.tar.zst"
                        be8ad04e53804f18cfeec5b9cba1877af1516762de60891e115826fcfe95166751a68e24cdf351a021294e3189c31ce3c2db0ebf9c1d4d4ab6fea1468f73ced5
                        "https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-gcc-10.2.0-11-any.pkg.tar.zst"
                        9aa77c84ee19b47393b880144022094aae8149320b85ec68983af15933cb15da2c2957ae68d865cd2f9cc02d12ce556796aeb98bf0707464dbb08e0009e6946a
                        "https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-binutils-2.39-2-any.pkg.tar.zst"
                        799163399451c059c95becc076875e48def3f872362cd592e27cb8d8e3b9c746080f977e0069a69d93d25b3f80cfcc14c3578079b40483287ffb70fd03178894
                        "https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-crt-git-9.0.0.6454.b4445ee52-1-any.pkg.tar.zst"
                        f83220b712fa2403f9a7cfed8040de1c3acd5d25827aeb79e04a8cd754b02c710f4230b6b9eba665187db71a6b6430ae143a584756039bf29113209f1109dbe2
                        "https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-headers-git-9.0.0.6454.b4445ee52-1-any.pkg.tar.zst"
                        51338b8aa1cb78019da39e1c5eeb5fbf5e4d008e34be550c55eba54c869bbb9e76d79832cc52f6ed41db3be008c6b2b79fe3e4ff040cf76aac7220259c0f0ca6
                        "https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-libiconv-1.16-2-any.pkg.tar.zst"
                        542ed5d898a57a79d3523458f8f3409669b411f87d0852bb566d66f75c96422433f70628314338993461bcb19d4bfac4dadd9d21390cb4d95ef0445669288658
                        "https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-windows-default-manifest-6.4-3-any.pkg.tar.xz"
                        77d02121416e42ff32a702e21266ce9031b4d8fc9ecdb5dc049d92570b658b3099b65d167ca156367d17a76e53e172ca52d468e440c2cdfd14701da210ffea37
                        "https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-zlib-1.2.13-1-any.pkg.tar.zst"
                        c433c2248965c2efc015f6e085f27aeac042db893ffbcfa9eb21ada489a90a7c6e175316885742cc78c0524c71bbaf5947bf677f55c9d479a6a49a62abb6e1db
                        "https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-zstd-1.4.9-1-any.pkg.tar.zst"
                        092ec6f153a65affa4e78ca47644248fc510484529dec0cac4ad69fbc146ce48cf4176155054a908c9c1afc57b4541cd8d5234390c5563b8ca197ed129941e1b
                )
            else()
                message(FATAL_ERROR "Unknown architecture '${VCPKG_TARGET_ARCHITECTURE}' for MinGW Fortran build!")
            endif()

            set(MINGW_BIN "${MSYS_ROOT}/${MINGW_PATH}/bin")
            vcpkg_add_to_path(PREPEND "${MINGW_BIN}")
            list(APPEND ARGS_OUT -DCMAKE_GNUtoMS=ON
                                 "-DCMAKE_Fortran_COMPILER=${MINGW_BIN}/gfortran.exe"
                                 "-DCMAKE_C_COMPILER=${MINGW_BIN}/gcc.exe"
                                 "-DCMAKE_Fortran_FLAGS_INIT:STRING= -mabi=ms ${MACHINE_FLAG} ${VCPKG_Fortran_FLAGS}")
            # This is for private use by vcpkg-gfortran
            set(vcpkg_find_fortran_MSYS_ROOT "${MSYS_ROOT}" PARENT_SCOPE)
            set(VCPKG_USE_INTERNAL_Fortran TRUE PARENT_SCOPE)
            set(VCPKG_POLICY_SKIP_DUMPBIN_CHECKS enabled PARENT_SCOPE)
            set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${SCRIPTS}/toolchains/mingw.cmake" PARENT_SCOPE) # Switching to MinGW toolchain for Fortran
            if(VCPKG_CRT_LINKAGE STREQUAL "static")
                set(VCPKG_CRT_LINKAGE dynamic PARENT_SCOPE)
                message(STATUS "VCPKG_CRT_LINKAGE linkage for ${PORT} using vcpkg's internal gfortran cannot be static due to linking against MinGW libraries. Forcing dynamic CRT linkage")
            endif()
            if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
                set(VCPKG_LIBRARY_LINKAGE dynamic PARENT_SCOPE)
                message(STATUS "VCPKG_LIBRARY_LINKAGE linkage for ${PORT} using vcpkg's internal gfortran cannot be static due to linking against MinGW libraries. Forcing dynamic library linkage")
            endif()
        else()
            message(FATAL_ERROR "Unable to find a Fortran compiler using 'CMakeDetermineFortranCompiler'. Please install one (e.g. gfortran) and make it available on the PATH!")
        endif()
    endif()
    set(${additional_cmake_args_out} ${ARGS_OUT} PARENT_SCOPE)
endfunction()
