@value
@register_passable("trivial")
struct IdentityTransform:
    """The identity transform."""

    fn get_transform(self) -> Transform:
        fn transform(x: Float64, /) -> Float64:
            return x

        return transform
