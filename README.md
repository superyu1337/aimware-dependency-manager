# aw-dependency-manager
A repo with a bunch of scripts and a dependency loader.

file structure:
```
/files/<dependency name>/<version>/load.lua
/src/loader.lua
```

## Idea:
Loader tries to load from local cache first:  
`./cache/adm/<depdenency name>/<version>/loader.lua`  
If it can find the file, load it in and return it.  
    -> everything went as planned.  
  
If nothing is found then the loader get requests to:  
`$raw_repo_url/files/<dependency name>/<version>/loader.lua`  
If the script is found, get request it, then cache it under:  
`./cache/adm/<depdenency name>/<version>/loader.lua`  
then load the file and return it.  
    -> everything went as planned.  
  
If nothing is found, return an error.  
    -> something went horribly wrong, unrecoverable error. (oof size large)  
