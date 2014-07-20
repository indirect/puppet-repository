# check out name/repo into ~/src/name/repo
define repository::github(
  $path     = "${boxen::config::srcdir}/$title",
  $source   = $title,
  $protocol = undef,
  $user     = undef,
  $config   = undef,
  $remote   = undef,
  $extra    = undef,
  $force    = undef
) {
  $options = hash_compact({
    path => $path,
    source => $source,
    protocol => $protocol,
    user => $user,
    config => $config,
    remote => $remote,
    extra => $extra,
    force => $force
  })
  ensure_resource("repository", "$path", $options)
}