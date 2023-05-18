# nvim

My Neovim configuration files for my Arch Linux worstations.

* uses folke/lazy.nvim as the plugin manager
* using Mason to install some LSP/DAP/NullLs related tooling
* nvim configuration neither driven by nor coupled to Mason
* nvim.cmp based completions
* always a work in progress

## Installation Location

To install these files to `$XDG_CONFIG_HOME/nvim` from standalone
alone `grscheller/nvim` repo:


```
   $ ./nvInstall
```

If `grscheller/nvim` is a submodule of `grscheller/dotfiles` do not run
it directly from the submodule.  It is designed to be called from
a subshell of `dfInstall`.

## Public Domain Declaration

<p xmlns:dct="http://purl.org/dc/terms/"
   xmlns:vcard="http://www.w3.org/2001/vcard-rdf/3.0#">
  <a rel="license"
     href="http://creativecommons.org/publicdomain/zero/1.0/">
     <img src="http://i.creativecommons.org/p/zero/1.0/88x31.png"
          style="border-style: none;"
          alt="Unlicense"></a>

  To the extent possible under law,
  [Geoffrey R. Scheller](https://github.com/grscheller)
  has waived all copyright and related or neighboring rights
  to [grscheller/nvim](https://github.com/grscheller/nvim).
  This work is published from the United States of America.
</p>

See [LICENSE](LICENSE) for details.
