# godot_table

A table control which can be sort and dynamic update for Godot



## Usage

### create table in editor

![image](https://github.com/sericaer/godot_table/blob/main/gif/create_table.gif)



### select row

![image](https://github.com/sericaer/godot_table/blob/main/gif/select_row.gif)



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



### known issues

no real-time preview for color changes



### demo

[https://github.com/sericaer/godot_table_demo]: 



