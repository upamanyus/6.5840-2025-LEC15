From stdpp Require Export prelude.
From New Require Export proof_prelude.
Require Export New.code.demo.
Require Export generatedproof.demo.

Global Notation "❴ P ❵ e ❴ x .. y , 'returns' pat ; Q ❵" :=
  (∀ Φ, P -∗ ▷ (∀ x , .. (∀ y , Q -∗ Φ #pat%V) .. ) -∗ WP e {{ Φ }})
    (at level 20, x closed binder, y closed binder) : stdpp_scope.

Global Notation "❴ P ❵ e ❴ 'returns' pat ; Q ❵" :=
  (∀ Φ, P -∗ ▷ (Q -∗ Φ #pat%V) -∗ WP e {{ Φ }})
    (at level 20) : stdpp_scope.

Section def.
Context `{hG: heapGS Σ, !ffi_semantics _ _, !goGlobalsGS Σ}.
Global Program Instance : IsPkgInit demo := ltac2:(build_pkg_init ()).
End def.
