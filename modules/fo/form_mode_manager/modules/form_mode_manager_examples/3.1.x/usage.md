<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Form Mode Manager examples is a demo/sandbox submodule that installs ready-made configuration — a `node_form_mode_example` content type, a `contributor` node form mode, a `contributor` role, and a sample front page — so you can try Form Mode Manager without building anything by hand.

---

This is an **example** module, not something to enable in production. On install it imports config (`config/install`): a content type `node_form_mode_example` with a body and a `field_picture` image field, a node form mode `contributor` (`core.entity_form_mode.node.contributor`) with its form display, a view display, and a `contributor` user role. It adds a controller page at `/form_mode_manager_examples` (route `form_mode_manager_examples.front_page`, permission `access content`) that links to the demo content type's add form, and a `hook_menu_local_actions_alter()` that surfaces the "Add node as contributor" local action on that page. It declares no config schema, no permissions, no services, and no `configure` route of its own — everything it demonstrates is standard Form Mode Manager behavior applied to the shipped example config.

---

- Try Form Mode Manager end-to-end without creating any content types or form modes yourself.
- Explore a working `contributor` node form mode on the `node_form_mode_example` content type.
- See how a form mode appears as an add route/tab after it is enabled on a bundle.
- Visit the demo landing page at `/form_mode_manager_examples` to jump into the example.
- Learn the "Add node as contributor" local action pattern for form-mode add links.
- Inspect the shipped `core.entity_form_mode.node.contributor` config as a reference.
- Use the example `contributor` role to test per-form-mode access permissions.
- Study the example form display vs default display to understand form-mode field differences.
- Reproduce a role-restricted content-entry workflow from working sample config.
- Demo Form Mode Manager to stakeholders quickly on a scratch site.
- Reference the `field_picture` image field setup used by the example content type.
- Copy the example config as a starting point for a real form-mode setup.
- Verify a fresh install of Form Mode Manager works by exercising the example.
- Teach editors how alternative form modes look before rolling out your own.
- Use it in automated tests/screenshots as a known form-mode fixture.
