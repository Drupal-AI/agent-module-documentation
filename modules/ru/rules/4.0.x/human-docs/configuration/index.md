# Configuration

Everything Rules does is managed under **Configuration → Workflow → Rules**
(`/admin/config/workflow/rules`), which has three areas: **Reactions**,
**Components**, and **Settings**. Rules and components are configuration entities,
so they export and deploy with `drush config:export` like any other config.

## Create a reaction rule (event → conditions → actions)

1. Go to **Reactions → Add reaction rule**
   (`/admin/config/workflow/rules/reactions/add`).
2. Give the rule a **Label** and pick one or more **events** to react to — for
   example "After saving a new entity," "User has logged in," or "Cron maintenance
   tasks are performed." The available events come from Rules' event plugins.
3. Save, then edit the rule to add:
   - **Conditions** — each a condition plugin such as *Data comparison*, *Entity is
     of bundle*, or *User has role*. Conditions can be grouped with AND/OR logic,
     and the actions run only if the conditions pass.
   - **Actions** — each an action plugin such as *Show a message on the site*, *Send
     email*, or *Add user role*. Actions run in order, can loop over lists, and can
     pass data from one to the next.
4. Save. The rule is stored as configuration and fires automatically whenever its
   event occurs. You can **enable** or **disable** a rule from the reactions list
   without deleting it.

## Reusable logic — Rules Components

A **Rules Component** is a saved, parameterized piece of logic with its own context
variables that you invoke from other rules (via the "Rules component" action) or
from code. Manage them under **Components**
(`/admin/config/workflow/rules/components`); add one at
`/admin/config/workflow/rules/components/add/rule`. Use a component to avoid
duplicating the same action chain across many reaction rules.

**Reaction rule vs. component:** a reaction rule is bound to events and runs
automatically; a component is standalone, reusable logic that something else must
call.

## Settings

The **Settings** form (`/admin/config/workflow/rules/settings`, permission
**Administer rules**) controls logging and debugging:

- **System log level** *(default: warning)* — the level at which rule‑evaluation
  errors are written to the system log.
- **Enable debug log** *(off by default)* — turn on the Rules debug log to trace
  exactly what fired and why. Invaluable when a rule isn't behaving.
- **Also log debug to the system log** *(off by default)* — send debug output to
  the system log as well.
- **Debug log level** *(default: debug)* — the level used for the debug log
  channel.

## Permissions

Rules provides granular permissions so you can split administration by area:

| Permission | What it allows |
|-----------|----------------|
| **Administer rules** | Full Rules configuration, including the settings form. |
| **Administer rules reactions** | Add, edit, delete, enable, and disable reaction rules. |
| **Administer rules components** | Add, edit, and delete rules components. |
| **Bypass rules access** | Configure any event/condition/action regardless of per‑plugin restrictions. A trusted/restricted permission. |
| **Access rules debug** | View the Rules debug log. |

## Drush commands

Rules ships `rules:*` commands for managing rules from the command line:

```bash
drush rules:list            # list reaction rules and/or components (alias: rlst)
drush rules:enable  NAME    # enable a reaction rule (alias: renb)
drush rules:disable NAME    # disable a reaction rule (alias: rdis)
drush rules:delete  NAME    # permanently delete a rule (alias: rdel)
```
