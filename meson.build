project('ags', 'c',
          version: run_command('cat', join_paths(meson.project_source_root(), 'version')).stdout().strip(),
    meson_version: '>= 0.62.0',
    	  license: ['GPL-3.0-or-later'],
  default_options: [ 'warning_level=2', 'werror=false', ],
)

app_id = 'com.github.Aylur.ags'
prefix = get_option('prefix')
libdir = join_paths(prefix, get_option('libdir'))
extensiondir = join_paths(libdir, meson.project_name())
datadir = join_paths(prefix, get_option('datadir'))
pkgdatadir = join_paths(datadir, app_id)
bindir = join_paths(prefix, get_option('bindir'))

dependency('glib-2.0')
dependency('gobject-introspection-1.0', version: '>= 1.49.1')
dependency('gio-2.0', version: '>= 2.56.0')
dependency('gjs-1.0', version: '>= 1.73.1')
dependency('gtk+-3.0', version: '>= 3.0')

subproject('gvc',
  default_options: [
    'package_name=' + app_id,
    'pkgdatadir=' + pkgdatadir,
    'pkglibdir=' + libdir,
    'static=false',
    'introspection=true',
    'alsa=false'
  ]
)

subproject('gutils',
  default_options: [
    'pkgdatadir=' + pkgdatadir,
    'pkglibdir=' + libdir,
  ]
)

subproject('gshell',
  default_options: [
    'pkgdatadir=' + pkgdatadir,
    'pkglibdir=' + libdir,
  ]
)

subdir('src')

meson.add_install_script(
  'post_install.sh',
  datadir,
  pkgdatadir,
  bindir,
  app_id,
  get_option('build_types').to_string(),
  meson.project_source_root()
)

gutils_gir = subproject('gutils').get_variable('gir')
gshell_gir = subproject('gshell').get_variable('gir')
custom_target(
  'TypeScript Types for GIR',
  input: [gutils_gir, gshell_gir],
  depends: [gutils_gir, gshell_gir],
  output: '@types',
  command: [find_program('generate_gir_dts.sh'), meson.current_build_dir(), '@INPUT@', '@OUTPUT@'],
  build_by_default: true,
  build_always_stale: true
)