from os import getenv

from transform import Transform
from transform.add import AddTransform
from transform.identity import IdentityTransform
from transform.multiply import MultiplyTransform
from transform.compose import ComposeTransform


fn setup_transforms() -> DynamicVector[Transform]:
    var ts = DynamicVector[Transform]()
    ts.push_back(AddTransform(1).get_transform())
    # ts[0] = Add one
    # ts = x -> (x + 1)
    ts.push_back(MultiplyTransform(2).get_transform())
    # ts[1] = Multiply by two
    # ts = x -> ((x + 1) * 2)
    ts.push_back(ComposeTransform(ts[0], ts[1]).get_transform())
    # ts[2] = Add one, then multiply by two
    # ts = x -> ((((x + 1) * 2) + 1) * 2)
    ts.push_back(ComposeTransform(ts[1], ts[0]).get_transform())
    # ts[3] = Multiply by two, then add one
    # ts = x -> ((((((x + 1) * 2) + 1) * 2) * 2) + 1)
    ts.push_back(ComposeTransform(ts[2], ts[3]).get_transform())
    # ts[4] = Add one, then multiply by two, then multiply by two, then add one
    # ts = x -> ((((((((((x + 1) * 2) + 1) * 2) * 2) + 1) + 1) * 2) * 2) + 1)
    # ts = x -> 32x + 57
    return ts


fn merge_transforms_1(ts: DynamicVector[Transform]) -> Transform:
    var t: Transform = ts[0]
    for idx in range(1, ts.size):
        t = ComposeTransform(t, ts[idx]).get_transform()
    return t


fn merge_transforms_2(ts: DynamicVector[Transform]) -> Transform:
    var t: Transform = IdentityTransform().get_transform()
    for idx in range(ts.size):
        t = ComposeTransform(t, ts[idx]).get_transform()
    return t
