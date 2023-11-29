from transform import Transform
from common import setup_transforms, merge_transforms_1


fn main() -> None:
    let ts: DynamicVector[Transform] = setup_transforms()
    let merged_fn: Transform = merge_transforms_1(ts)
    let value: Float64 = merged_fn(1.0)
    print("value:", value)
