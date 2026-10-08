# Configuration

Entity Workflow builds on two core systems, so most of its "configuration" is done
through core's **Workflows** and **Workspaces** UIs, with the module's submodules
supplying starter workflows and its permissions deciding who can do what.

## 1. Get the starter workflows in place

Enable the **Entity Workflow Content** and **Entity Workflow Workspace**
submodules (see [Installation](../installation/index.md)). They install basic,
ready-to-use workflows so you do not have to define states and transitions from
scratch. If you prefer to build your own, you can instead define a workflow in the
core Workflows UI.

## 2. Review and adjust the workflows

Go to **Configuration → Workflow → Workflows**
(`/admin/config/workflow/workflows`). Here you can:

- Review the states and transitions the submodules created.
- Adjust which entity types and bundles each workflow applies to.
- Add or rename states and transitions to match your editorial process.

## 3. Set up workspaces

Because Entity Workflow gives each entity its own workflow *within* a workspace,
make sure **Workspaces** is configured for your team. Create the workspaces your
editors will use for staging changes. Content edited inside a workspace is
isolated there until the workspace is published.

## 4. Check who can transition and publish — the key step

Both moving content between states and publishing a workspace are controlled by
permissions (the module's own plus core's). At **People → Permissions**
(`/admin/people/permissions`), confirm that:

- The right roles can **execute the workflow transitions** you care about.
- Only the roles you trust can **publish a workspace** — publishing pushes all the
  staged changes live at once.

Getting these permissions right is the most important configuration task: they
define who can move content forward and who can release a whole workspace to the
live site. Verify they match your editorial trust model.

## Typical flow once configured

1. An editor switches into a **workspace** and makes changes.
2. Each piece of content moves through its **workflow states** (for example draft
   → review → approved).
3. When everything is ready, a trusted user **publishes the workspace**, making
   all the staged changes live together.
