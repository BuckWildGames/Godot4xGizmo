# Godot4xGizmo
A simple to use but complex and powerful gizmo tool to add to any Godot 4x project.

![Desktop Screenshot 2024 08 30 - 14 52 26 37](https://github.com/user-attachments/assets/d8e6f506-61d4-4374-888f-4b0a7e0951b1)

I had been looking for a gizmo tool that was flexable, easy to use and functioned well, but could not find what I was looking for, thats what made me decide to create this tool.

![Desktop Screenshot 2024 08 30 - 15 08 17 18](https://github.com/user-attachments/assets/e0e912c1-df10-40ce-8484-d113ad19955a)

There is two nodes included with the addon, GizmoController and GizmoReceiver.

The GizmoController node should be added as a child of the active Camera3D node.

The GizmoReceiver node should be added as a child of any object you wish to move.

The GizmoController node has one function that can be directly called or called using a signal.

The GizmoReceiver node has two functions that can be directly called or called using a signal.

(*Any other function should not be called outside of the existing calls.)

All scripts include comments for anyone that wants to try to understand or modify them.

![Desktop Screenshot 2024 08 30 - 14 53 49 02](https://github.com/user-attachments/assets/f5ff6308-29e4-43ae-ad23-cb8856ebe119)![Desktop Screenshot 2024 08 31 - 12 45 29 60](https://github.com/user-attachments/assets/414c2961-d2de-4401-9adb-324cd05beb38)

There is many different options that can be set in the inspector to customize or tailor the gizmo to work with your project.

Every option in the inspector has a description and should be easy to understand the function.

The GizmoController options are the default options and some overlapping options in the GizmoReceiver can overwrite the default.

(If the gizmo or axis is disabled in the GizmoController, the GizmoReceiver will not overwrite it.)

![Desktop Screenshot 2024 08 30 - 14 53 18 65](https://github.com/user-attachments/assets/d9c31681-2074-40f0-a609-450f828130f0)
![Desktop Screenshot 2024 08 30 - 14 52 55 69](https://github.com/user-attachments/assets/612e4cf6-08ec-4df2-9f52-ef762339c86d)

The gizmo can be used to move any 3D object just like the editor gizmo, it has full control over position, rotation and scale.

Any object that can detect inputs such as RigidBody3D, CharacterBody3D, StaticBody3D and Area3D can all be interacted with using a mouse click.

Any other Node3D can be moved using the gizmo but must be selected using a script or signal.

For physics nodes such as RigidBody3D and CharacterBody3D collision detection can be active while moving if you want it to collide with other objects in the scene.

![Desktop Screenshot 2024 08 30 - 14 54 57 95](https://github.com/user-attachments/assets/4b917fd4-f1d1-4f91-8826-a719b08dd15a)
![Desktop Screenshot 2024 08 30 - 15 39 24 74](https://github.com/user-attachments/assets/ad33b7a2-d205-4457-a14b-d18608ed82ef)

To install, simply unzip the file (gizmo.zip) and drop the gizmo folder into your project addons folder. (If it doesn't exist, create it.)

You can also use the sample project (gizmo-example.zip) to explore the features and learn how to implement it into your project.

Enjoy!

