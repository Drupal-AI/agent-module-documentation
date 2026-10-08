<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Price formatter adds a strikethrough "was price / discounted price / percent off" display to Drupal Commerce's existing Calculated price field formatter.

---

The module does not add a new formatter; it enhances Commerce's built-in **Calculated price** formatter (`commerce_price_calculated`). After installing it (requires **Commerce**, **Commerce Product** and **Commerce Promotion**, on Drupal `^9 || ^10 || ^11`), go to **Administration → Commerce → Configuration → Product variation types → your type → Manage display**, set the **Price** field's Format to **Calculated price**, open the formatter's settings and tick **"Enable discount format for calculated price"**. From then on, whenever that calculated price is rendered and a promotion has reduced it, the price is shown as the discounted amount with the original price struck through and a rounded **"(NN% off)"** label, using the module's small Twig template and stylesheet. The base and calculated prices come from Commerce's own price calculator, so the discount reflects the same promotion resolution Commerce applies. Two things to remember: the checkbox is only honoured on the variation type's **default** view display (the code reads that display specifically), and the module prints the raw price numbers, so if you need currency symbols or custom markup you will want to override the `commerce-price-formatter.html.twig` template. Because the rendered price is cached per product-variation cache tag, **clear the cache after changing promotions or display settings** so the frontend reflects the update.

---

- Show a promotional "was / now" price on a product variation.
- Display the original price struck through next to the discounted price.
- Add a rounded "percent off" label to a discounted product.
- Enable discount display via the Calculated price formatter's settings checkbox.
- Surface an active Commerce promotion's effect directly in the price.
- Show sale pricing on a product detail page.
- Present a strikethrough price on a product listing that uses the calculated formatter.
- Communicate savings to shoppers at the point of display.
- Reuse Commerce's own promotion calculation for the shown discount.
- Highlight a time-limited offer's reduced price.
- Show member or role-based promotional pricing where a Commerce promotion applies.
- Display bulk or quantity-based discount results in the price.
- Turn the discount display on or off per product variation type.
- Confirm the discount display is active from the Manage display summary line.
- Override the shipped Twig template to add currency symbols or custom markup.
- Style the discount output with the bundled CSS classes after customising the template.
- Keep listing and product pages consistent by rendering the calculated (promoted) price.
- Clear cache to refresh promoted prices after editing a promotion.
