<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A thin enabler module that makes the jQuery UI Progressbar widget (jQuery UI 1.13.2) available as a Drupal asset library after core dropped its bundled jQuery UI assets.

---

Drupal core deprecated and removed the jQuery UI asset libraries, splitting each widget into its own contrib module. `jquery_ui_progressbar` is the shim for the Progressbar widget: it ships no PHP, JS, config, permissions, or routes of its own — only an `info.yml` that depends on the base `jquery_ui` module. The actual progressbar assets (`progressbar-min.js` + `themes/base/progressbar.css`, version 1.13.2) live inside the `jquery_ui` module and are registered under the library id `jquery_ui_progressbar/progressbar` by `jquery_ui`'s `hook_library_info_alter()` — which only fires while this module is enabled. To use it, enable the module and attach `jquery_ui_progressbar/progressbar` from a render array, `#attached`, `*.libraries.yml` dependency, or Twig `attach_library()`. The library pulls in `core/jquery`, `jquery_ui/widget`, and the internal jQuery UI version/CSS libraries automatically. Note jQuery UI is unmaintained upstream; prefer a native HTML `<progress>` element or a modern JS solution for new work.

---

- Restore the `jquery_ui_progressbar/progressbar` asset library on Drupal 10/11 after core removed the bundled jQuery UI.
- Provide the dependency required by a contrib/custom module that still attaches `jquery_ui_progressbar/progressbar`.
- Render a determinate progress bar widget (`$('#el').progressbar({value: 37})`) in custom JS.
- Show an indeterminate/loading progress bar (`value: false`) while an operation runs.
- Display upload or batch progress in a custom admin screen using the jQuery UI widget.
- Attach the library from a custom render element via `#attached['library']`.
- Add the library as a dependency in a custom module's `*.libraries.yml`.
- Attach it from a Twig template with `{{ attach_library('jquery_ui_progressbar/progressbar') }}`.
- Keep a legacy theme or module that relies on `$.ui.progressbar` working during a Drupal 9 to 10/11 upgrade.
- Pair with `jquery_ui_slider` / other `jquery_ui_*` widgets to rebuild a legacy jQuery UI interface.
- Style the progress bar with the shipped jQuery UI base theme CSS.
- Bind to the widget's `create`/`change`/`complete` events for progress callbacks.
- Update a progress value dynamically as an AJAX request reports back.
- Serve as a documented, version-pinned (1.13.2) source of the widget instead of a hand-copied file.
- Satisfy the `jquery_ui_progressbar` module dependency declared by another project's `info.yml`.
- Provide a progress affordance in a multi-step form or wizard.
- Migrate away later by swapping the widget for a native `<progress>` element once dependents are updated.
