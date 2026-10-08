<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Json table — agent index

Field **widget + formatters** to store tabular data as **JSON** and render it as **tables, charts
(Google Charts/Chart.js), or a gridstack** (`json_gridstack` submodule). Version **1.0.31**. Core
`^9||^10||^11||^12`.

Content-editing/display (no access role). Raw formatter uses `#markup` (filtered by `Xss::filterAdmin`
— broad tag set), so mind who may edit these fields.
