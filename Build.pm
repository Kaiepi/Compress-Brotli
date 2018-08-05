use LibraryMake;

class Build {
    method build($dir) {
        my %vars = get-vars($dir);
        if $*VM.osname ~~ 'darwin' | 'freebsd' | 'openbsd' {
            %vars{'CXX'}      = 'clang++';
            %vars{'CFLAGS'}   = '-Wall -std=c++11 -lstdc++ -dynamiclib -undefined -suppress -flat_namespace';
            %vars{'NAME_LIB'} = '-install_name';
            %vars{'SUFFIX'}   = '.dylib';
        } else {
            %vars{'CXX'}      = 'g++';
            %vars{'CFLAGS'}   = '-Wall -std=c++11 -lstdc++ -shared -fPIC';
            %vars{'NAME_LIB'} = '-soname';
            %vars{'SUFFIX'}   = '.so';
        }

        process-makefile($dir.IO.child('stub').Str, %vars);
        chdir 'stub';
        shell(%vars<MAKE>);
        chdir $*CWD.IO.parent;
    }
}
