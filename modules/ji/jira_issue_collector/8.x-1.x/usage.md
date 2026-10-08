<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JIRA Issue Collector adds an Atlassian JIRA Issue Collector widget to site pages, letting users submit feedback/issues into JIRA.

---

JIRA Issue Collector adds Atlassian's JIRA Issue Collector widget to the site's pages — a
feedback/bug-report button that lets users submit issues (with optional screenshot) directly into a
JIRA project. It is configured at `jira_issue_collector.routing` (the collector's embed snippet/URL and
which pages show it) and provides its own permissions.

Use it to gather user feedback or bug reports into JIRA during testing or on internal tools. It embeds
Atlassian's third-party JavaScript, so consider: the widget loads external JS (a supply-chain/privacy
consideration), and you likely want it shown only to intended audiences (e.g. staff/testers, not all
anonymous visitors) via its display settings/permissions. It is an integration feature with no
content-access role beyond controlling where the widget appears.

---

- Add a JIRA Issue Collector widget.
- Let users submit issues into JIRA.
- Collect feedback with screenshots.
- Configure the collector embed.
- Choose which pages show the widget.
- Provide its own permissions.
- Gather bug reports into JIRA.
- Embed Atlassian's JavaScript.
- Show the widget to intended audiences.
- Restrict the widget to staff/testers.
- Consider external-JS privacy.
- Use on internal tools.
- Report issues from the site.
- Route feedback to a JIRA project.
- Configure at the routing settings.
- Control widget display.
- Integrate Atlassian JIRA.
- Collect user feedback.
- Add a feedback button.
- Submit issues to JIRA.
