<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Component Example ships sample components showing what the parent module's single-YAML-file format looks like in practice.

---

The parent module's claim is that a JavaScript component becomes a Drupal block from one YAML file. A claim like that is only checkable against an example, because the interesting details — what the settings schema looks like, how the library is attached, what the component receives — are exactly what a description omits.

This submodule is that example, and it is the fastest way to evaluate whether the format fits a project before committing to it.

**Note the parent module cannot currently be enabled.** `component` 1.0.0-rc5 tags its
`ComponentDiscovery` service as `plugin_manager_cache_clear` without implementing
`clearCachedDefinitions()`, so core's cache-clear collector fatals — verified, and because module
installation ends with a cache clear it fatals mid-install and leaves modules half-installed. This
example therefore cannot be enabled either, and both are documented from source.

That does not make reading it pointless. The YAML format is legible on its own, and if the parent's
one-line defect is fixed, this is where to start.

---

- See the single-file component format.
- Check what a settings schema looks like.
- See how a library is attached.
- Evaluate the format before adopting it.
- Copy a sample component as a starting point.
- Understand what a component receives.
- Read the format despite the parent defect.
- Recognise the parent's cache-clear fatal.
- Avoid enabling it until the tag is fixed.
- Plan a component library on the format.
- Compare with SDC as an alternative.
- Teach the format from a working sample.
- Prototype a component definition.
- Document this component's conventions for the team.
- Review it during a component audit.
- Verify its behaviour after a theme change.
