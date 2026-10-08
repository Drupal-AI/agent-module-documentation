Ludwig lets a Drupal module declare its external PHP library dependencies in a `ludwig.json` file and download them without Composer, giving non-Composer-managed sites a way to satisfy library requirements manually.

---

Ludwig is a manual alternative to Composer for installing the third-party PHP libraries a contrib module needs. A module ships a `ludwig.json` file listing each required package with a `version` and an archive `url` (typically a GitHub `.zip`); Ludwig discovers these files across all modules and profiles via Drupal's `ExtensionDiscovery`, even for extensions that aren't installed. The **Packages report** at `Admin → Reports → Packages` (`/admin/reports/packages`, gated by the core `access site reports` permission) lists every declared package with its namespace, paths, resource type, version, requiring module, and a status (`Installed`, `Missing`, `Not installed`, `Overridden`, and more). Visiting that page automatically downloads any `Missing` packages — fetching each archive over HTTP (Guzzle), extracting it with the archiver manager, and copying it into the requiring module's `lib/<vendor>-<name>/<version>/` directory — then flushes caches; a companion `/admin/reports/packages_skip` route shows the same report without triggering downloads. Autoloading is wired up by `LudwigServiceProvider`, which reads each downloaded library's own `composer.json` `autoload` section and registers its PSR-4 / PSR-0 namespaces into Drupal's `container.namespaces` parameter at container build time, so no cache of package data is needed. PSR-4 and PSR-0 libraries load automatically; `classmap` and `files` libraries are not autoloaded and require the module to call the `ludwig.require_once` service from its `.module`/`.install` file. When multiple modules require the same package, Ludwig keeps the highest version and marks the rest `Overridden`, and a hook alters the core Update Manager form to remind maintainers to download libraries before running database updates. Note that in 2.0.x Ludwig provides no Drush command — downloads happen through the Packages report page. It is aimed at sites that deliberately avoid Composer-managed workflows.

---

- Install a contrib module's PHP library dependencies on a site that does not use Composer.
- Declare a module's external libraries in a `ludwig.json` file instead of `composer.json` `require`.
- Download all `Missing` libraries by visiting the Packages report at `/admin/reports/packages`.
- Review the status of every Ludwig-managed package (Installed / Missing / Overridden / etc.) in one report.
- Inspect declared packages without triggering a download using `/admin/reports/packages_skip`.
- Autoload a PSR-4 library shipped by a module without adding it to the site's Composer autoloader.
- Autoload a PSR-0 library (Ludwig converts PSR-0 paths so core can register them).
- Pin a specific library version per module via the `version` key in `ludwig.json`.
- Point a package at a GitHub archive URL so it can be fetched and unpacked automatically.
- Place downloaded libraries under each module's own `lib/` directory rather than a shared vendor dir.
- Require `require_once` for `classmap` / `files` libraries via the `ludwig.require_once` service.
- Declare different library versions for different Drupal core majors using core-compatibility suffixes on the package key.
- Resolve duplicate library requirements across modules by keeping the highest version (others marked Overridden).
- Get a warning on the Update Manager form reminding you to download libraries before running DB updates.
- Bootstrap library discovery even for modules that are not yet installed (ExtensionDiscovery scan).
- Ship a distribution/profile whose modules pull their libraries via Ludwig instead of Composer.
- Re-download a library after removing it, since Ludwig replaces the target directory cleanly on extract.
- Identify libraries Ludwig cannot handle automatically (legacy `include-path`, `target-dir`, unknown types) from the report.
- Flush caches automatically after new libraries are installed so autoloading picks them up.
- Give editors/administrators visibility into missing third-party dependencies via the reports UI.
- Maintain a lightweight non-Composer site where adding a module means downloading its libraries through Ludwig.
- Debug why a Ludwig-managed class isn't found by checking the package's status and resource type in the report.
- Provide a manual fallback when a hosting environment forbids running Composer on the server.
- Read a module's declared library URL from the report to download it by hand if automatic download fails.
- Decide when to use Ludwig (non-Composer sites) versus Composer (the recommended default for managed sites).
