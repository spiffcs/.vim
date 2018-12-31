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
To remove `foo`:
```
cd ~/.vim
git submodule deinit pack/plugins/start/foo
git rm -r pack/plugins/start/foo
rm -r .git/modules/pack/plugins/start/foo
```

### Updating plugins
To update `foo`:
```
cd ~/.vim/pack/plugins/start/foo
git pull origin master
```
It is recommended to first `git fetch origin master` a plugin, review changes, and then `git merge`.

To update all the plugins:
```
cd ~/.vim
git submodule foreach git pull origin master
```

Note that new commits to plugins create uncommitted changes in the main repository.
After any updates in the submodules, you need to commit the main repository as well:
```
cd ~/.vim
git commit -am "Updated plugins."
```

On another machine, if a `git pull` for the main repository leads to uncommitted changes in the submodules (as a few plugins got updated), perform `git submodule update` to change the recorded state of the submodules.

Even though slightly complicated, submodules are a necessary devil when you want to maintain an easily-cloneable `.vim` repository.
The other option is to _not_ version-control submodules at all by adding a line `pack` in `~/.vim/.gitignore`, and manually add plugins on a new machine.
