@value
@register_passable("trivial")
struct MultiplyTransform:
    """A struct which provides a Transform which does multiplication."""

    var value: Float64

    fn get_transform(self) -> Transform:
        fn transform(x: Float64, /) -> Float64:
            return x * self.value

        return transform
