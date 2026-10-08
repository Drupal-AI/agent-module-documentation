Display Builder UI provides the admin screens and permissions for managing Display Builder profiles, pattern presets and instances.

---

`display_builder_ui` is the administrative layer of the Display Builder project. On its own the base `display_builder` module only ships the engine; this submodule adds the routes, list builders and forms under **Structure → Display builder** (`/admin/structure/display-builder`) to create, edit, delete and list `display_builder_profile` config entities, `pattern_preset` config entities, and to browse the `display_builder_instance` entities that hold each display's draft. It defines three permissions (`administer display builder profile`, `administer pattern preset`, `view display builder instance`), supplies the `ProfileListBuilder`, `InstanceListBuilder`, `PatternPresetListBuilder` and an `InstanceListFilterForm`, and registers menu/task/action links and a small `instance-list` CSS library. It depends only on `display_builder`.

---

- Reach the Display Builder admin at Structure → Display builder.
- Create a new Display Builder profile (which islands are enabled for a builder screen).
- Edit an existing profile's islands and their per-island settings.
- Delete a profile that is no longer needed.
- List all profiles with their labels and weights.
- Manage pattern presets: add, edit and delete reusable component sub-trees.
- List all pattern presets at Structure → Display builder → Preset.
- Browse every display builder instance at Structure → Display builder → Instances.
- Filter/sort the instance list with the instance filter form.
- Grant `administer display builder profile` to trusted site builders who curate builder configuration.
- Grant `administer pattern preset` to users who maintain the shared preset library.
- Grant `view display builder instance` to users who need to see the instance admin list.
- Use the local tasks/actions this submodule adds to move between profiles, presets and instances.
- Provide the UI needed before editors can be pointed at a specific builder profile.
- Style the instance list via the bundled `instance_list` CSS library.
