<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Security Analysis — agent index

Admin **security-posture dashboard**: compares SecKit / Login Security / Password Policy / CAPTCHA / Security Review config against a bundled ideal, shows a letter+percentage rating and charts at `/admin/security_analysis`, and exports an `.xlsx` via PhpSpreadsheet. Version **3.0.0**, core 8–11.

Permissions: `access security analysis admin overview`, `download security analysis report`. Depends on phpspreadsheet. Read-only (changes no settings). Report library loads Chart.js from a public CDN.