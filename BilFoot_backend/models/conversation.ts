import { Types, Schema, model } from "mongoose";

interface IConversationSchema {
  members: Types.ObjectId[];
  messages: {
    from_email: string;
    content: string;
    date: Date;
  };
}

const conversationSchema = new Schema<IConversationSchema>({
  members: { type: [Schema.Types.ObjectId], required: true },
  messages: {
    from_email: { type: String, required: true },
    content: { type: String, required: true },
    date: { type: Schema.Types.Date, required: true },
  },
});

export default model<IConversationSchema>("conversation", conversationSchema);
