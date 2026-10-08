Webform Demo: Group is an example/demo submodule of Webform Group that, on install, builds a working demonstration of the Webform + Group integration — group types, roles, a demo group node with an attached `webform_group_contact` webform, sample users and submissions, and path aliases under `/webform/group`.

---

This is a demonstration module, not intended for production. Its `hook_install()` (in `webform_demo_group.install`) programmatically creates the artifacts needed to show group-role-based webform access in action: group types (`webform_group_a`, `webform_group_b`) with a full set of group roles (administrator, manager, member, reviewer, outsider, anonymous), a demo webform (`webform_group_contact`) whose handlers are disabled, sample groups, users assigned to those roles, and generated submissions, plus path aliases under `/webform/group`. Its `.module` adds a small `hook_block_access()` tweak to hide the group operations block outside group context in the legacy Bartik theme. Most artifacts ship as `config/install` YAML (group types, roles, relationship types, the webform, form/view displays). Enable it on a throwaway/dev site to explore the integration, then read the parent module's docs to configure your own. Uninstalling removes the demo content it generated.

---

- Stand up a ready-made demo of group-role webform access without manual setup.
- Inspect example group types (`webform_group_a`, `webform_group_b`) and their roles.
- See a `webform_group_contact` webform wired to a group node.
- Study how group roles map onto webform access rules in real config.
- Explore sample users pre-assigned to administrator/manager/member/reviewer roles.
- Review generated example submissions scoped to a group.
- Learn the expected content model (group → group node → webform) for the integration.
- Use as a reference when configuring your own group webforms.
- Demonstrate the integration to stakeholders on a dev site.
- Provide a functional-test-like baseline for exploring access behavior.
- Examine the bundled path aliases under `/webform/group`.
- See the Bartik group-operations block access tweak as an integration example.
- Copy the config/install YAML as a starting point for a real setup.
- Verify Webform Group is working end to end after installation.
- Reset the demo by uninstalling and re-enabling the module.
