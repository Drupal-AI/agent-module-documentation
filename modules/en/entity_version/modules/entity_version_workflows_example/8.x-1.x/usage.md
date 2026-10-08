<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Version Workflows Example is a demo sub-module that installs a ready-made "Example" content type, a version field, an Entity Version settings mapping and a Content Moderation workflow whose transitions are pre-wired with version-increment rules, so you can see Entity Version Workflows working end to end.

---

This is reference/demo scaffolding for `entity_version_workflows`, not a production feature. Enabling it installs (via `config/install`): a node type **`entity_version_workflows_example`** ("Example", revisions on); an `entity_version` field storage `field_version` and a field on the Example type (default `0.0.0`); an `entity_version.settings.node.entity_version_workflows_example` config marking `field_version` as the bundle's **main** version field; a view display; and a Content Moderation workflow **`example_workflow`** with states Draft → Validated → Published and transitions whose `entity_version_workflows` third-party settings demonstrate the rules — **create_new_draft** increases `patch` (only when values changed), **validate** increases `minor` and resets `patch`, **publish** increases `major` and resets `minor`. The module also registers `TestCheckEntityChangedSubscriber` (service, constructed with the state service): it subscribes to `CheckEntityChangedEvent` and, only when the state key `entity_version.test_skip_title_on` is TRUE, adds the node **title** to the change-detection blacklist — a hook used by the project's tests to exercise the "check values changed" path. Because it ships enforced demo config and a test-oriented subscriber, this module is meant for evaluation, local demos and automated tests; you would normally build your own content type, field, settings mapping and workflow rather than enable it on a real site.

---

- Try Entity Version Workflows end-to-end without configuring anything by hand.
- Get a working "Example" content type with a version field already attached.
- See a Draft → Validated → Published moderation workflow pre-wired with version rules.
- Observe `patch` increasing when a new draft is created (if values changed).
- Observe `minor` increasing and `patch` resetting on the Validate transition.
- Observe `major` increasing and `minor` resetting on the Publish transition.
- Use it as reference config when authoring your own workflow version rules.
- Copy the shipped `workflows.workflow.example_workflow.yml` as a template for third-party settings.
- Demonstrate the feature to a content team or stakeholder quickly.
- Exercise the "Check values changed" gate in a controlled setup.
- Toggle the `entity_version.test_skip_title_on` state to skip the title in change detection during tests.
- Provide a fixture for automated functional/kernel tests of the workflow integration.
- Learn how an `entity_version_settings` mapping ties a field to a bundle.
- Inspect a complete example of the `entity_version` field default value in config.
- Validate a local install of the Entity Version project is working.
- Enable temporarily on a scratch site, then uninstall once you understand the setup.
