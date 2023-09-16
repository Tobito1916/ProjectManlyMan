using Godot;

public partial class Movement : CharacterBody2D
{
	[Export]
	public int Speed { get; set; } = 400;

	private AnimatedSprite2D _animatedSprite;
    public override void _Ready()
    {
        _animatedSprite = GetNode<AnimatedSprite2D>("CharacterSprite");
    }
	public void GetInput()
	{

		Vector2 inputDirection = Input.GetVector("left", "right", "up", "down");
		Velocity = inputDirection * Speed;
		if (Input.IsActionPressed("right"))
		{
			_animatedSprite.Play("walk_right");
		}
		else if (Input.IsActionPressed("left"))
		{
			_animatedSprite.Play("walk_left");
		}
		else if (Input.IsActionPressed("up"))
		{
			_animatedSprite.Play("walk_right");
		}
		else if (Input.IsActionPressed("down"))
		{
			_animatedSprite.Play("walk_left");
		}
		else
		{
			_animatedSprite.Play("idle");
		}
	}

	public override void _Process(double delta){
	
	}

	public override void _PhysicsProcess(double delta)
	{	
		GetInput();
		MoveAndSlide();
	}
}
