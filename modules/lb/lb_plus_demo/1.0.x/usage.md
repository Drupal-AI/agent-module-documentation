<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A dependency-only wrapper module whose sole purpose is to install Layout Builder + (lb_plus) together with Field Sample Value for demonstration on Simplytest.me.

---

The module ships no PHP, routes, permissions, services or configuration — its `.info.yml` simply declares dependencies on `lb_plus:lb_plus` and `field_sample_value:field_sample_value`. Enabling it enables that stack in one step, which is convenient for spinning up a throwaway Layout Builder + evaluation environment. Field Sample Value supplies placeholder field content so layouts have something to render in the demo.

Because it is a meta-package, there is nothing to configure here; all behaviour comes from the modules it depends on. It is not intended for production use — it exists to make "try Layout Builder +" a single click on Simplytest.

---
- Enable Layout Builder + and Field Sample Value together in one step
- Spin up a quick Layout Builder + demo on Simplytest.me
- Provide sample field values so demo layouts render content
- Evaluate the LB+ editing experience without manual setup
- Bundle the LB+ "and friends" stack for evaluation
- Use as a starting point for a local LB+ playground
- Remove after evaluation without leaving custom config behind
- Share a reproducible LB+ environment with a colleague
- Try LB+ features without hand-picking each dependency
- Demo LB+ to a client from a throwaway sandbox
- Pin the demo stack to compatible dependency versions
- Avoid manually enabling multiple modules for a demo
- Bootstrap a screenshot/recording environment for LB+
- Reset a demo by reinstalling a single module
- Compare core Layout Builder against LB+ quickly
- Use as a reference for how to package a demo wrapper module
