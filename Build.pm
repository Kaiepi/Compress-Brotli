use Panda::Common;
use Panda::Builder;
use LibraryMake;

class Build is Panda::Builder {
    method build($workdir) {
        make("$workdir/stub"); 
    }
}
