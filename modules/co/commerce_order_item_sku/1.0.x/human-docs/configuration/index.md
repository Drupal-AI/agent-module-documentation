# Configuration

Storing SKUs is **opt-in**. Enabling the module does nothing on its own — you turn
the behavior on per order item type. There are two steps: save your preferences on
the module's settings form, then enable the SKU-storage trait on each order item
type you want it to apply to.

## 1. Save your preferences

Open the module's **settings form** and save your preferences there. Even if you
don't change anything, saving establishes the module's configuration so it behaves
as expected.

## 2. Turn on the trait per order item type

1. Go to **Commerce → Configuration → Order item types** and edit the order item
   type you want (for example *Default*).
2. In the **Traits** section, tick **"Store purchased entity SKU"**.
3. Save the order item type.

From now on, every new order item of that type records the purchased entity's SKU
at purchase time, keeping it in your order history even if the product variation's
SKU later changes or the variation is deleted. Repeat for each order item type that
needs it.

## 3. (Optional) Hide the SKU field on the order-item form

Depending on how you set SKUs, you may not want staff typing into the stored SKU
field directly — you'd rather it be captured automatically. If so, go to the order
item type's **Manage form display** tab and **hide** the SKU field so it isn't
editable on the order-item form.

## Save

Save each form after you change it. The stored-SKU behavior applies going forward,
to order items created after the trait is enabled.
