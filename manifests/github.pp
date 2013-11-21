# check out name/repo into ~/src/name/repo
define repository::github(
  $path = $title, $source = undef, $protocol = undef,
  $user = undef, $config = undef, $extra = undef, $force = undef
) {
  repository { "${boxen::config::srcdir}/$path":
    source => $path,
    protocol => $protocol,
    user => $user,
    config => $config,
    extra => $extra,
    force => $force
  }
}
