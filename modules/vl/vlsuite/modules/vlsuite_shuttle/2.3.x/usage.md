<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Shuttle installs and configures the suite's base in one step, which the project recommends to shorten initial setup.

---

A sixteen-submodule suite with interdependencies is a setup problem before it is a feature. Enabled in the wrong order, or with a piece missing, the result is a half-configured system whose symptoms do not point at the cause. The project's own description recommends installing this module "to optimize initial setup time", which is a polite way of saying: do not assemble it by hand.

What it does is enable and configure the base — media, blocks, layouts, the Layout Builder UI, utility classes, icons, tabbed layouts and the headings menu block — as a coherent starting point for a custom build.

Read it as the counterpart to `vlsuite_demo`. Demo installs example **content** so you can see the suite working; shuttle installs the **configuration** so you can start building. A project usually wants shuttle, and wants demo only long enough to evaluate.

The thing to check afterwards is what it configured, because a setup module's decisions become the site's assumptions. Look at the layout restrictions, the enabled utility classes and the text formats before adding to them.

---

- Install the VLSuite base in one step.
- Avoid assembling the suite by hand.
- Get a coherent starting configuration.
- Shorten initial project setup.
- Enable the base submodules in the right order.
- Start a custom build on the suite.
- Distinguish setup from demo content.
- Review what the setup configured.
- Check layout restrictions after setup.
- Check enabled utility classes.
- Adjust the base rather than build it.
- Reproduce a standard setup across projects.
- Diagnose a half-configured suite.
- Onboard a new project quickly.
- Document the base configuration for a team.