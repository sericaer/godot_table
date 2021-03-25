# godot_table
A table control which can be sort and dynamic updata for Godot

![image](https://github.com/sericaer/godot_table/blob/main/demo.gif)



## Usage

### add table in editor



### select row





### dynamic change data

gdscript

```gdscript
func _on_Button_pressed():
	$Table.set_rows([['100', '200'], ['300', '400']])
```



C#

```
    private void _on_Button_pressed()
    {
        var param = new Godot.Collections.Array() { new Godot.Collections.Array() { "100", "200" }, new Godot.Collections.Array() { "400", "300" } };

        GetNode("Table").Call("set_rows", new object[] { param });
    }
```



### demo

[https://github.com/sericaer/godot_table_demo]: 



