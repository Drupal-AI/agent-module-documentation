A hidden, test-only submodule of Workbench Access that provides a worked example of the `hook_workbench_access_scheme_update_alter()` hook, which lets a module rewrite an access scheme's stored `scheme_settings`.

---

Workbench access hooks test (`workbench_access_hooks`) is a `hidden: true` submodule that lives under the parent's `tests/modules/` directory, so it is only meant to be enabled in automated tests, not on production sites. Its single `.module` file implements `hook_workbench_access_scheme_update_alter()`: whenever a scheme has a `scheme` plugin id, the hook overwrites the passed-by-reference `$settings` array with `['test' => 'test']`. It exists to demonstrate and test how a third-party module can intercept and transform the `scheme_settings` of an `access_scheme` config entity (typically during data migration or update paths), and it depends on the parent `workbench_access` module. There is no configuration, no UI, no services, and no permissions — reading its one hook implementation is the entire point.

---

- Study a minimal, working implementation of `hook_workbench_access_scheme_update_alter()`.
- See where a hook that rewrites `scheme_settings` belongs (the `.module` file).
- Copy the pattern to transform a scheme's stored settings from your own module.
- Enable it in automated tests that exercise Workbench Access scheme update/alter behaviour.
- Learn how the `$config` argument is inspected (`$config->get('scheme')`) before altering.
- Understand that the hook mutates `$settings` by reference with no return value.
- Confirm the correct hook function-name convention (`{module}_workbench_access_scheme_update_alter`).
- Reference the exact hook signature (`array &$settings`, `\Drupal\Core\Config\Config $config`).
- Use it as a smoke-test target when verifying the parent module's alter dispatch fires.
- Model how a migration path rewrites legacy scheme settings into the new plugin shape.
- Demonstrate guarding an alter so it only touches schemes your own module owns.
- Illustrate that `scheme_settings` is plugin-specific data any module may transform.
- Provide a template for kernel/functional tests that assert altered settings persist.
- Show how a submodule declares its dependency on the parent (`workbench_access:workbench_access`).
- Serve as an example of a `hidden: true` test-only module shipped under `tests/modules/`.
- Verify that Workbench Access invokes scheme-update alter hooks at all.
