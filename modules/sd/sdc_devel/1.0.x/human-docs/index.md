# SDC Devel — manual setup guide

**SDC Devel** (`sdc_devel`) is a development aid for people who build
**Single‑Directory Components** (SDC) in Drupal. When you author a component,
its behavior is defined by two files: a `*.component.yml` definition and a Twig
template. SDC Devel scans every registered component on your site, validates
both of those files, and reports any problems it finds — undefined props or
slots, use of forbidden or deprecated Twig functions and filters, a definition
that doesn't match core's SDC schema, and other risky or non‑standard
constructs.

You review the results either in the admin UI, on a report page that lists every
component's issues with the exact source line and a snippet of the offending
Twig, or on the command line with a Drush command that you can wire into CI to
fail a build when a component is not clean. Under the hood the Twig checks are
driven by a pluggable rule system (the `twig_validator_rule` plugin type), so a
team can add its own rules to enforce a house style on which Twig constructs
components are allowed to use.

This is strictly a developer and CI tool — it has **no effect on the rendered
site at runtime**, adds no configuration, and defines no permissions of its own
beyond the report route (which reuses core permissions). Think of it as a linter
for your component library. It requires the `twig/twig ~3.19` library, which
Composer pulls in for you.

This guide is written for a **human** clicking through the admin UI and running
Drush. If you want terse, token‑cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Once enabled, the component report sits at **Reports → UI Components**
(`/admin/reports/ui-components`). To see it, a user needs both the *Access
components page* (`access components page`) and core's *View site reports*
(`access site reports`) permissions. The report has an overview page, a details
page, and a per‑component page.

## How to use it

There are two ways to run the validation, and they cover the same checks.

**In the admin UI.** Go to **Reports → UI Components**. The overview lists every
component SDC Devel found and how many problems each has. Drill into a single
component to see each message tagged with a severity, the Twig node type it came
from, the source line, and a snippet of the code that triggered it. This is the
quickest way to learn *why* something is flagged while you are authoring.

**On the command line.** Run the validator with Drush:

```bash
drush sdc-devel:validate my_theme
# or the short alias:
drush sdcv my_theme
```

- The first argument is the machine name of the **module or theme** whose
  components you want to check. You can pass a comma‑separated list to validate
  several projects at once.
- Add an optional second argument — a single component id such as
  `my_theme:card` — to validate just that one component instead of the whole
  project.
- Add `--install` to have Drush temporarily install a disabled project, validate
  it, then uninstall it again.

The command prints a table with the columns *component*, *severity*, *message*,
*type*, *line*, and *source*. It reports success when a project is clean and a
warning with a problem count when it is not, which is exactly what you want for a
CI gate — for example, run `drush sdc-devel:validate my_theme` in your pipeline
and fail the build on warnings. See the sibling
[`agent/drush/validate.md`](../agent/drush/validate.md) for the full command
reference, and [`agent/plugins/twig-validator-rule.md`](../agent/plugins/twig-validator-rule.md)
for how to write your own validation rule.
