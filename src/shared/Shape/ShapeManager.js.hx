package;

import Shape;


class ShapeManager {
    private var Shapes:Array<Shape>;

    public function updateShapes() {
        for(shape in this.Shapes) {
            // use the origin of the shape, and spin around
            
            shape.x = shape.originX + shape.scale * Math.cos(shape.rotationPos);
            shape.y = shape.originY + shape.scale * Math.sin(shape.rotationPos);
        }
    }
}