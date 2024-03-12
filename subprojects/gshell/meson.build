project('gshell', 'c')

pkglibdir = get_option('pkglibdir')
pkgdatadir = get_option('pkgdatadir')

cc = meson.get_compiler('c')

libsources = ['shell-polkit-agent.c', 'shell-polkit-agent.h']

deps = [
  dependency('gobject-2.0'),
  dependency('gio-2.0'),
  dependency('polkit-agent-1')
]

libgshell = shared_library(
  'gshell',
  sources: libsources,
  dependencies: deps,
  install: true
)

gnome = import('gnome')
gir = gnome.generate_gir(
  libgshell,
  sources: libsources,
  nsversion: '1.0',
  namespace: 'GShell',
  symbol_prefix: 'shell',
  identifier_prefix: 'Shell',
  includes: ['GObject-2.0', 'Gio-2.0', 'PolkitAgent-1.0'],
  install_dir_gir: pkgdatadir,
  install_dir_typelib: pkglibdir,
  install: true
)[0]
