Bee Hotel Upgrade bundles cross-release fixes and helper utilities for keeping a Bee Hotel site consistent when upgrading.

---

A maintenance submodule that packages the fixes and helper code (such as Util/Dates) required when moving a Bee Hotel site between releases. It exists so upgrade-time data/config adjustments live in one place rather than in the core module. It ships no public routes or permissions; enable it when following an upgrade path that calls for it. Depends on bee_hotel.

---

- Apply cross-release fixes when upgrading Bee Hotel.
- Keep date/data helpers used by upgrade routines in one module.
- Isolate upgrade concerns from the core bee_hotel module.
- Support consistent data/config across Bee Hotel versions.
- Enable only when an upgrade path requires it.
