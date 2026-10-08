<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Container Dumper (container_dumper) — agent index
**Writes the compiled Symfony container to an XML file after each cache rebuild for static analysis.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10 || ^11 · **PHP:** 7.2+
- **Depends on:** system (>= 8.5)
- **Configure:** `/admin/config/development/container-dumper` (`container_dumper.settings`, permission `administer container dumper settings`).
- **Mechanism:** `ContainerDumperServiceProvider` registers `DumpCompilerPass`, which uses Symfony `XmlDumper` to write to a Drupal-root-relative path on container compilation (cache rebuild).

**Security:** Only route is the permission-gated settings form; no anonymous or mutating HTTP endpoint. Caution: the dump path is admin-chosen and relative to the web root — configure a location that is NOT web-accessible, since the dumped XML exposes the full service container. See [configure/setup.md](configure/setup.md).
