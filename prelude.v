From stdpp Require Export prelude.
From New Require Export proof_prelude.

Global Notation "❴ P ❵ e ❴ x .. y , 'returns' pat ; Q ❵" :=
  (∀ Φ, P -∗ ▷ (∀ x , .. (∀ y , Q -∗ Φ #pat%V) .. ) -∗ WP e {{ Φ }})
    (at level 20, x closed binder, y closed binder) : stdpp_scope.

Global Notation "❴ P ❵ e ❴ 'returns' pat ; Q ❵" :=
  (∀ Φ, P -∗ ▷ (Q -∗ Φ #pat%V) -∗ WP e {{ Φ }})
    (at level 20) : stdpp_scope.
