# Dotfiles Repo Instructions

When adding or removing tracked files, all of the following must be updated:

1. **README.md** — update the repo structure diagram and symlink mappings
2. **syncFiles.sh** — update the FILES array (system → repo)
3. **installFiles.sh** — update the FILES array (repo → system)
4. **diffFiles.sh** — update the FILES array (repo vs system)

The FILES array in all three scripts must stay identical.
