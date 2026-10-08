<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# charts_highstock — agent orientation

- Charts-module plugin adding Highcharts Stock (Highstock) as a chart library; depends on charts + charts_highcharts.
- Provides a Charts type plugin (src/) + Views include; config flows through the Charts module, no standalone form.
- No routes, permissions, anonymous endpoints, or server-side network calls. Nothing security-sensitive.
- Purely additive integration; client-side rendering.
