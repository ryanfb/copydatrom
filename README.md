# CopyDATROM

This is designed to be an incredibly simple ROM "renaming" (actually just copying while renaming) utility for use with DAT files. The other tools I found for dealing with DAT files and ROM management/renaming/organization were more confusing to me than just giving up and writing this.

## Usage

    bundle exec ./copydatrom.rb datfile.dat rom-source-dir rom-dest-dir

CopyDATROM will then:

 * parse `datfile.dat`
 * check that `rom-dest-dir` exists (and try to create it if not)
 * recursively go through every file in `rom-source-dir` and:
     * calculate its SHA1 hash
     * check for a matching SHA1 hash in `datfile.dat`
     * copy it to `rom-dest-dir` with the corresponding ROM name specified in `datfile.dat`, if a match is found

That's it! All your files in `rom-source-dir` should remain completely untouched.

CopyDATROM will **not**:

 * modify or delete your source files
 * go inside zip/7z/rar files
 * generate zip/7z/rar files
 * generate split/merged/non-merged sets
 * generate statistics about how many ROMs you have or are missing
 * calculate CRC32/MD5 hashes (your DAT file must have SHA1 hashes)

If you want to make a "1G1R" (one game, one ROM) romset, you can use CopyDATROM with no-intro DAT files to first rename/copy your ROMs into no-intro's naming, then use the [1g1r-romset-generator](https://github.com/andrebrait/1g1r-romset-generator) on the renamed directory.
