<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A developer tool that writes the compiled Symfony service container to an XML file after each cache rebuild, so static analysers can understand the site's services.
---
A service provider (`ContainerDumperServiceProvider`) registers a compiler pass (`DumpCompilerPass`) that runs during container compilation. When a dump path is configured, the pass serialises the `ContainerBuilder` with Symfony's `XmlDumper` and writes it to a file relative to the Drupal root (creating the directory if needed). The path is set at `/admin/config/development/container-dumper` (`administer container dumper settings`); with no path configured, nothing is dumped.

The settings form and its route are gated by the `administer container dumper settings` permission — there is no anonymous route and nothing is exposed over HTTP by the module itself. The one operational caution is that the dumped XML describes the full service container and is written to an admin-chosen path relative to the web root: an administrator should point it at a location that is not web-accessible (outside the public files/webroot), since the container definition can reveal internal structure. Setup: enable the module, set a (non-public) dump path, and rebuild caches.
---
- Dump the compiled service container to XML for tooling.
- Feed the container definition to static analysers (e.g. PHPStan/Psalm).
- Configure the output path at the settings form.
- Regenerate the dump automatically after every cache rebuild.
- Point the dump at a path outside the web root for safety.
- Inspect registered services and their arguments offline.
- Aid IDE/analyser resolution of Drupal service types.
- Disable dumping by clearing the configured path.
- Restrict configuration with `administer container dumper settings`.
- Create the target directory automatically if it is missing.
- Support Drupal 8–11 and PHP 7.2+.
- Debug service wiring by reading the XML output.
- Keep the container snapshot in sync with each rebuild.
- Use the dump in CI to analyse service definitions.
- Diagnose dependency-injection issues from the dumped graph.
- Avoid runtime overhead by only writing on compilation.
- Store the dump under a private files path for analysis jobs.
- Verify a module's services are registered as expected.
- Provide analysers a canonical view of tagged services.