# .vim
Go where you go and do what you do, but always with vim

## Using git-submodules to version-control Vim plugins
If you like to keep regressions out of your vim setup it is a good idea to setup some version control.

Some confusion for this solution can come from having plugins installed inside something like `.vim/bundle` (if you use [pathogen](https://github.com/tpope/vim-pathogen)), or inside `.vim/pack` (if you use Vim 8's packages).

One solution leverages git [submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) so you don't need to push all that extra code around.

### Creating the repository
Initialize a git repository inside your `.vim` directory, add everything (including the vimrc), and then commit and push to a GitHub/BitBucket/GitLab repository:

```
cd ~/.vim
cp ~/.vimrc vimrc
git init
git add *
git commit -m "Initial commit."
git remote add origin https://github.com/username/reponame.git
git push -u origin master
```

To enable submodules:
```
cd ~/.vim
git submodule init
```

### Installing plugins
To install plugins (say always-loaded `foo` and optionally-loaded `bar`, located at `https://github.com/spiff90/foo` and `https://github.com/spiff90/bar`, respectively):

```
git submodule add https://github.com/spiff90/foo.git bundle/foo
git submodule add https://github.com/spiff90/bar.git bundle/bar
git commit -m "Added submodules."
```

### Replicating the repository on a machine
- Clone the repository (_recursively_ to clone plugins as well):

    ```
    git clone --recursive https://github.com/username/reponame.git
    ```
    
- Symlink `.vim` and `.vimrc`:

    ```
    ln -sf reponame ~/.vim
    ln -sf reponame/vimrc ~/.vimrc
    ```
    
- Generate helptags for plugins:
    ```
    vim
    :helptags ALL
    ```
    
### Removing plugins
To remove a submodule you need to:
- Delete the relevant section from the .gitmodules file.
- Stage the .gitmodules changes git add .gitmodules
- Delete the relevant section from .git/config.
- Run git rm --cached path_to_submodule (no trailing slash).
- Run rm -rf .git/modules/path_to_submodule (no trailing slash).
- Commit git commit -m "Removed submodule <name>"
- Delete the now untracked submodule files rm -rf path_to_submodule

### Updating plugins
`git submodule update --remote`


### Installing YCM
Keeping YCM in-sync is a pain with modules: [YCM](https://github.com/Valloric/YouCompleteMe)
Make sure you follow the instructions for install if you want to use it on another machine

### Alternatives
Even though slightly complicated, submodules are a necessary devil when you want to maintain an easily-cloneable `.vim` repository.
The other option is to _not_ version-control submodules at all by adding a line `pack` in `~/.vim/.gitignore`, and manually add plugins on a new machine.
