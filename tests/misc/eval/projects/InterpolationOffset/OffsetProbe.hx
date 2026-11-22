import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.ExprTools;

class OffsetProbe {
    public static function check() {
        final source = "alpha + (beta * gamma)";
        for (offset in [0, 23, 8192]) {
            final origin = Context.makePosition({file: "OffsetProbeInput.hx", min: offset, max: offset + source.length});
            final parsed = Context.parseInlineString(source, origin);
            final positions = [];
            function visit(node:Expr) {
                switch node.expr {
                    case EConst(CIdent(name)):
                        final position = Context.getPosInfos(node.pos);
                        positions.push(name + ":" + (position.min - offset) + "-" + (position.max - offset));
                        if (position.file != "OffsetProbeInput.hx") throw position.file;
                    default:
                }
                ExprTools.iter(node, visit);
            }
            visit(parsed);
            if (positions.join(",") != "alpha:0-5,beta:9-13,gamma:16-21") throw positions;
        }
    }
}
