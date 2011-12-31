## ssh-alias

A ruby script which makes it easy to add, delete and list the ssh aliases in `~/.ssh/config`.

Installation is simple:

    $ git clone git://github.com/jamesmoss/ssh-host-aliases.git
    $ cd ssh-host-aliases
    $ chmod +x .

To add a host run `./new-ssh-alias.rb` and follow the prompts. The script also takes care of transferring your public key to the server so you won't have to re-enter your password every time you connect.

If you want to remove an alias use `./delete-ssh-alias.rb` and follow the prompts. `./list-ssh-aliases.rb` will print a list of every alias you've got setup.