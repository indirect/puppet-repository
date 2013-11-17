# check out name/repo into ~/src/name/repo
define github_repo {
  repository { "${boxen::config::srcdir}/$name":
    source => $name
  }
}
