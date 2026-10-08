Monitoring Demo is a demonstration/onboarding submodule (built for simplytest.me) that sets up sample content, a search index and a landing page so the Monitoring module's sensors have realistic data to report on out of the box.

---

On install (`monitoring_demo_modules_installed()`), the module creates demonstration nodes and comments (`_monitoring_setup_create_node()`, `_monitoring_setup_create_comment()`) and installs a Search API server/index (`config/install/search_api.server.demo`, `search_api.index.demo`) plus optional Article/Page/comment config, so content/comment/search sensors have something to measure. It provides a landing page at `/monitoring-demo` (`monitoring_demo.front_page` route → `FrontPage::content`, permission `access content`) that orients a visitor to the monitoring reports. It pulls in a broad dependency set — `node`, `comment`, `search_api`, `search_api_db`, `rest`, `basic_auth`, `dblog`, `file`, and the base `monitoring` module — so the demo exercises many sensor types. It is a demo fixture: it provides no configuration UI, permissions, services or plugins of its own, and is not intended for production sites.

---

- Spin up a ready-to-explore Monitoring demo on a throwaway/simplytest.me site.
- Populate sample nodes and comments so content/comment sensors show non-zero values.
- Install a Search API demo index so the unindexed-items sensor has data.
- Land on `/monitoring-demo` to get oriented before visiting `/admin/reports/monitoring`.
- Evaluate the Monitoring module quickly without building content by hand.
- Demonstrate watchdog/dblog sensors with real log entries.
- Show REST + basic auth wiring alongside monitoring for an integration demo.
- Provide a teaching example of sensors across content, search and logs.
- Give a workshop/demo audience a populated dashboard immediately.
- Test threshold behavior against realistic demo data.
- Use as a reference for what a monitored site looks like.
- Seed data for screenshots/documentation of the Monitoring UI.
- Trial Search API + monitoring integration together.
- Verify the sensor auto-creation behavior after enabling related modules.
- Provide a consistent baseline environment for reproducing sensor issues.
- Kick the tyres on the reports UI with data present.
- Demonstrate the content-entity aggregator sensor with demo nodes.
- Show comment-activity monitoring with seeded comments.
- Onboard new users to Monitoring with a guided landing page.
