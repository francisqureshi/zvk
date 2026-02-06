const eng = @import("eng");
const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer if (gpa.deinit() == .leak) @panic("memory leaked");

    const allocator = gpa.allocator();

    const wndTitle = "Vulkan Book";
    var game = Game{};
    var engine = try eng.engine.Engine(Game).create(allocator, &game, wndTitle);
    try engine.run(allocator);
}

const Game = struct {
    pub fn cleanup(self: *Game) void {
        _ = self;
    }

    pub fn init(self: *Game, engCtx: *eng.engine.EngCtx, arenaAlloc: std.mem.Allocator) !eng.engine.InitData {
        _ = self;
        _ = engCtx;

        const leftQuadModel = eng.mdata.ModelData{
            .id = "LeftQuadModel",
            .meshes = &[_]eng.mdata.MeshData{
                .{
                    .id = "LeftQuadMesh",
                    .vertices = &[_]f32{
                        -0.8, // '0' Vertex Triplet
                        0.5,
                        0.0,
                        -0.2, // '1' Vertex
                        0.5,
                        0.0,
                        -0.2, // '2' Vertex
                        -0.5,
                        0.0,
                        -0.8, // '3' Vertex
                        -0.5,
                        0.0,
                    },
                    .indices = &[_]u32{
                        0, // Tri 0
                        1,
                        2,
                        0, // Tri 1
                        2,
                        3,
                    },
                },
            },
        };

        const rightQuadModel = eng.mdata.ModelData{
            .id = "RightQuadModel",
            .meshes = &[_]eng.mdata.MeshData{
                .{
                    .id = "RightQuadMesh",
                    .vertices = &[_]f32{
                        0.8, // '0' Vertex Triplet
                        0.5,
                        0.0,
                        0.2, // '1' Vertex
                        0.5,
                        0.0,
                        0.2, // '2' Vertex
                        -0.5,
                        0.0,
                        0.8, // '3' Vertex
                        -0.5,
                        0.0,
                    },
                    .indices = &[_]u32{
                        0, // Tri 0
                        1,
                        2,
                        0, // Tri 1
                        2,
                        3,
                    },
                },
            },
        };

        const models = try arenaAlloc.alloc(eng.mdata.ModelData, 2);
        models[0] = leftQuadModel;
        models[1] = rightQuadModel;

        return .{ .models = models };
    }

    pub fn input(self: *Game, engCtx: *eng.engine.EngCtx, deltaSec: f32) void {
        _ = self;
        _ = engCtx;
        _ = deltaSec;
    }

    pub fn update(self: *Game, engCtx: *eng.engine.EngCtx, deltaSec: f32) void {
        _ = self;
        _ = engCtx;
        _ = deltaSec;
    }
};
