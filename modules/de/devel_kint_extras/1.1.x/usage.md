DEPRECATED / OBSOLETE. Devel Kint Extras extended Devel's Kint dumper to also show the methods and statics available on a dumped object. It no longer works because Devel removed its Kint integration in v5.4.0; use the standalone Kint module instead.

---

Devel Kint Extras was a small development-only add-on for the Devel module. It replaced
Devel's `kint` dumper class with its own `KintExtended` (extending Devel's `Kint` dumper) via
`hook_devel_dumper_info_alter()`, tuning Kint so that a `kint()`/`ksm()` dump also surfaced an
object's available methods and static properties (it removed Kint's IteratorPlugin, registered
internal-function aliases, disabled RichRenderer folding, and shallow-blacklisted the service
container to keep dumps readable). The project is now marked `lifecycle: obsolete` in its
`.info.yml` (link: https://www.drupal.org/node/3549864) and **cannot be enabled** on Drupal 11
(`drush en devel_kint_extras` errors "module 'devel_kint_extras' is obsolete"). The reason: the
Kint integration it depended on was removed from Devel in the 5.4.0 release, so there is no
longer a Devel `kint` dumper to extend. The maintainers direct users to the standalone
[Kint module](https://www.drupal.org/project/kint); feature requests for this module's
behaviour should be filed in the Kint module's issue queue. Its uninstall/update hook
(`devel_kint_extras_update_8001`) simply resets Devel's dumper back to `kint` if it had been
set to `kint_extended`. This documentation is a source-only stub: no live-site introspection or
execution is possible because the module is obsolete and un-installable.

---

- (Historical) Show an object's available methods and static properties in a Kint dump when debugging with Devel — now removed; install the standalone Kint module instead.
