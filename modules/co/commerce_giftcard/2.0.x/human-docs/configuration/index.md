# Configuration

Setting up gift cards is a short sequence: create a **type**, issue or **generate**
cards, add the **redemption pane** to checkout, and (optionally) sell cards as
products. Then grant the right **permissions**.

## 1. Create a gift-card type

A gift-card type is the "bundle" every card belongs to.

1. Go to **Commerce → Configuration → Gift card types**
   (`/admin/commerce/config/giftcard_types`) and click **Add gift card type**.
2. Set an **admin label** (e.g. "Holiday gift card"), a customer-facing **display
   label** (e.g. "Gift card"), and the generated **code length** (default 8
   characters).
3. Save. You might create several types — for example "Holiday" and "Store credit" —
   each with its own code length.

## 2. Issue or generate gift cards

Gift cards live at **Commerce → Gift cards** (`/admin/commerce/giftcards`).

- **Issue one card:** click **Add gift card**, choose the type, and set its **code**,
  **balance**, owner, status, and (optionally) the **stores** it may be spent in.
- **Bulk-generate cards:** use the **Generate gift cards** form at
  `/admin/commerce/giftcards/generate` to produce a batch of cards with unique codes
  (of the type's configured length) — handy for a promotion or launch. Codes are
  checked case-insensitively against existing cards so they're guaranteed unique.

Restricting a card's **stores** limits where it can be redeemed on a multi-store site.
Setting a card's status to disabled takes a compromised card out of use without
deleting its transaction history.

## 3. Let customers redeem a code at checkout

Redemption is delivered by a checkout pane:

1. Go to **Commerce → Configuration → Checkout flows** and edit the flow customers
   use.
2. Add the **Gift card redemption** pane (`commerce_giftcard_redemption`) to a step —
   typically alongside the order summary or payment step.
3. In the pane's settings, tick **allow multiple** if you want several gift cards to
   apply to one order.

At checkout the customer types in their code. A gift-card **adjustment** is then
applied to the order — deliberately **last** in the pricing pipeline (after every
other adjustment), so the card discounts the fully-adjusted total. A card's balance
carries across multiple orders until it's used up.

## 4. (Optional) sell gift cards as products

To let customers *buy* gift cards:

1. Edit the product variation type you'll use for gift cards
   (**Commerce → Configuration → Product variation types**).
2. Enable the **Gift card purchase** trait on it.

Now purchasing that product issues or credits a real gift card automatically when the
order completes.

## 5. Refunds

From an order's admin page you can refund part of the order back onto a gift card
(`/admin/commerce/orders/{order}/giftcard-refund`), which records a transaction on the
card. This requires the **Administer gift cards** permission.

## Transactions (the audit trail)

Every balance change — a top-up, a redemption, a refund — is stored as a **gift-card
transaction** with an amount, the entity that caused it (such as an order), and an
optional comment. View a card's transactions at
`/admin/commerce/giftcards/{card}/transactions`.

## Permissions

At **People → Permissions**, grant the gift-card permissions to the appropriate roles:

| Permission | Grants |
|---|---|
| **Administer gift card types** | manage the gift-card types (the config bundles). |
| **Administer commerce gift card** | full admin over cards: the listing, add/edit/delete, the bulk **Generate** form, and the order **refund** form. |
| **Access gift card overview** | view the gift-card admin listing. |
| **View own gift cards** | view gift cards owned by the current user. |
| **Create gift card** | create gift-card entities. |
| **Create gift card transaction** | create transactions (balance changes). |

Give customer-service staff the overview/view permissions, and reserve **Administer
commerce gift card** for the team that generates and refunds cards.
