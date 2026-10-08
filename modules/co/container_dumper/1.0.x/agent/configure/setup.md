<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Container Dumper

1. Enable the module.
2. Go to `/admin/config/development/container-dumper` (requires `administer container dumper settings`).
3. Set **Path** — the file to dump the container to, including filename, **relative to the Drupal root**. Choose a location that is *not* web-accessible (e.g. a private/analysis directory), because the XML describes the whole service container.
4. Save. The container is (re)dumped after each cache rebuild.

## How it works
- `ContainerDumperServiceProvider::register()` adds `DumpCompilerPass` to the container build.
- On compilation the pass reads the configured path; if empty it does nothing.
- Otherwise it creates the target directory (mode 0775) if missing and writes the `XmlDumper` output via Symfony's Filesystem `dumpFile()`.

## Notes
- Because writes happen at compile time, there is no per-request overhead.
- To stop dumping, clear the Path value.
- Intended for developer/CI environments feeding static analysers; avoid enabling on production with a web-accessible path.
