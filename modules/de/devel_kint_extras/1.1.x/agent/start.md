# Devel Kint Extras (devel_kint_extras) — agent index (OBSOLETE)

**Do not install or enable this module.** Its `.info.yml` declares `lifecycle: obsolete`, and
Drupal core refuses to install obsolete modules — `ModuleInstaller` throws
`ObsoleteExtensionException("Unable to install modules: module 'devel_kint_extras' is obsolete.")`
(so `drush en devel_kint_extras` fails). It also depends on `devel:devel (^5.4)`, which no longer
provides the Kint integration this module hooks into.

A dev-only add-on for **Devel**. It did not register a dumper plugin of its own; instead
`hook_devel_dumper_info_alter()` swapped the *class* backing Devel's existing `kint` dumper to
`KintExtended` (`src/Plugin/Devel/Dumper/KintExtended.php`, extending Devel's `Kint` dumper). The
override lived entirely in `KintExtended::configure()`: it removed Kint's `IteratorPlugin`, set
`\Kint::$aliases` to the internal-function list, disabled `RichRenderer::$folder`, and
shallow-blacklisted `Psr\Container\ContainerInterface`, so a `kint()`/`ksm()` dump also surfaced an
object's available methods and static properties while staying readable. That is the module's entire
runtime surface.

**Why it is obsolete:** Devel **removed its Kint integration in v5.4.0**
(https://www.drupal.org/project/devel/releases/5.4.0), so there is no Devel `kint` dumper class left
to override. Deprecation notice: https://www.drupal.org/node/3549864; tracking issue:
https://www.drupal.org/project/devel_kint_extras/issues/3535663.

**Replaced by:** the standalone **Kint module** — https://www.drupal.org/project/kint. Port requests
for this module's features belong in the Kint module's issue queue.

- Depends on: `devel:devel (^5.4)` (info.yml); also requires the `kint-php/kint` PHP library
  (`^3.3 || ^4.0 || ^5.0 || ^6.0`, composer.json).
- Core: `^9 || ^10 || ^11`. Package: `Development`. Lifecycle: `obsolete`.
- No settings page (`configure` is null), no routes, no services, no permissions, no drush commands,
  no config schema, no new plugin types. Correctly start-only.

## Key facts (real machine names)
- Hooks implemented: `devel_kint_extras_help()` (help.page text) and
  `devel_kint_extras_devel_dumper_info_alter()` — the latter sets `$info['kint']['class'] = KintExtended::class`.
- Class: `Drupal\devel_kint_extras\Plugin\Devel\Dumper\KintExtended` extends
  `Drupal\devel\Plugin\Devel\Dumper\Kint`; the only override is the protected `configure()` method.
- Update hook: `devel_kint_extras_update_8001()` resets `devel.settings:devel_dumper` from
  `kint_extended` back to `kint` if it had been selected (`No changes necessary.` otherwise).
- No `configure/`, `api/`, or `plugins/` topic files exist: the module has no live, usable surface on
  Drupal 11 (it cannot be enabled) and provides only the single class + hooks above.
